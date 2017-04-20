(function () {
    'use strict';

    angular.module('mail.service', [])
        .service('Mails', function () {
            this.getAll = function () {
                return [
                    {
                        id: 1,
                        sender: 'John Billy',
                        title: 'Example#1',
                        date: '2014.05.04 13:13:10',
                        content: 'Dear John, <br/> <br/>Dear Jon, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi id neque quam. Aliquam sollicitudin venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.Morbi id neque quam. Venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.<br/><br/>Best wishes,<br/><br/>Ayo Oyedotun<br/>Editor-in-Chief<br/>Woculus Inc.<br/>234-805-392-8069 ext. 12<br/>Ayo@woculus.com<br/>http://woculus.com/<br/>',
                        flag: '',
                        replied: false,
                        read: false,
                        attachments: true
                    },
                    {
                        id: 2,
                        sender: 'Mack Johnson',
                        title: 'Example#3',
                        date: '2014.05.03 11:13:10',
                        content: 'Dear John, <br/> <br/>Lorem ipsum dolor sit  Morbi id neque quam. Aliquam sollicitudin venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.Morbi id neque quam. Venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.<br/><br/>Best wishes,<br/><br/>Ayo Oyedotun<br/>Editor-in-Chief<br/>Woculus Inc.<br/>234-805-392-8069 ext. 12<br/>Ayo@woculus.com<br/>http://woculus.com/<br/>',
                        flag: '',
                        replied: false,
                        read: false,
                        attachments: false
                    },
                    {
                        id: 3,
                        sender: 'Steve Oleg',
                        title: 'Example#2',
                        date: '2014.04.30 12:13:10',
                        content: 'Dear John, <br/> <br/>consectetur adipiscing elit. Morbi id neque quam. Aliquam sollicitudin venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.Morbi id neque quam. Venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.<br/><br/>Best wishes,<br/><br/>Ayo Oyedotun<br/>Editor-in-Chief<br/>Woculus Inc.<br/>234-805-392-8069 ext. 12<br/>Ayo@woculus.com<br/>http://woculus.com/<br/>',
                        flag: '',
                        replied: true,
                        read: true,
                        attachments: false
                    },
                    {
                        id: 4,
                        sender: 'Greg Abraham',
                        title: 'Example#5',
                        date: '2014.04.04 12:13:10',
                        content: 'Dear John, <br/> <br/>consectetur adipiscing elit. Morbi id neque quam. Aliquam sollicitudin venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.Morbi id neque quam. Venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.<br/><br/>Best wishes,<br/><br/>Ayo Oyedotun<br/>Editor-in-Chief<br/>Woculus Inc.<br/>234-805-392-8069 ext. 12<br/>Ayo@woculus.com<br/>http://woculus.com/<br/>',
                        flag: '',
                        replied: false,
                        read: true,
                        attachments: true
                    },
                    {
                        id: 5,
                        sender: 'Jesse Holmes',
                        title: 'Example#32',
                        date: '2014.04.04 12:13:10',
                        content: 'Dear John, <br/> <br/>consectetur adipiscing elit. Morbi id neque quam. Aliquam sollicitudin venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.Morbi id neque quam. Venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.<br/><br/>Best wishes,<br/><br/>Ayo Oyedotun<br/>Editor-in-Chief<br/>Woculus Inc.<br/>234-805-392-8069 ext. 12<br/>Ayo@woculus.com<br/>http://woculus.com/<br/>',
                        flag: '',
                        replied: true,
                        read: true,
                        attachments: true
                    },
                    {
                        id: 6,
                        sender: 'Jack Bold',
                        title: 'Example#32',
                        date: '2014.04.04 12:13:10',
                        content: 'Dear John, <br/> <br/>consectetur adipiscing elit. Morbi id neque quam. Aliquam sollicitudin venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.Morbi id neque quam. Venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.<br/><br/>Best wishes,<br/><br/>Ayo Oyedotun<br/>Editor-in-Chief<br/>Woculus Inc.<br/>234-805-392-8069 ext. 12<br/>Ayo@woculus.com<br/>http://woculus.com/<br/>',
                        flag: '',
                        replied: false,
                        read: true,
                        attachments: false
                    },
                    {
                        id: 7,
                        sender: 'John Doe',
                        title: 'Example#32',
                        date: '2014.04.04 12:13:10',
                        content: 'Dear John, <br/> <br/>consectetur adipiscing elit. Morbi id neque quam. Aliquam sollicitudin venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.Morbi id neque quam. Venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.<br/><br/>Best wishes,<br/><br/>Ayo Oyedotun<br/>Editor-in-Chief<br/>Woculus Inc.<br/>234-805-392-8069 ext. 12<br/>Ayo@woculus.com<br/>http://woculus.com/<br/>',
                        flag: '',
                        replied: false,
                        read: true,
                        attachments: true
                    },
                    {
                        id: 8,
                        sender: 'Jane Doe',
                        title: 'Example#32',
                        date: '2014.04.04 12:13:10',
                        content: 'Dear John, <br/> <br/>consectetur adipiscing elit. Morbi id neque quam. Aliquam sollicitudin venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.Morbi id neque quam. Venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.<br/><br/>Best wishes,<br/><br/>Ayo Oyedotun<br/>Editor-in-Chief<br/>Woculus Inc.<br/>234-805-392-8069 ext. 12<br/>Ayo@woculus.com<br/>http://woculus.com/<br/>',
                        flag: '',
                        replied: false,
                        read: true,
                        attachments: false
                    },
                    {
                        id: 9,
                        sender: 'John Smith',
                        title: 'Example#32',
                        date: '2014.04.04 12:13:10',
                        content: 'Dear John, <br/> <br/>consectetur adipiscing elit. Morbi id neque quam. Aliquam sollicitudin venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.Morbi id neque quam. Venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.<br/><br/>Best wishes,<br/><br/>Ayo Oyedotun<br/>Editor-in-Chief<br/>Woculus Inc.<br/>234-805-392-8069 ext. 12<br/>Ayo@woculus.com<br/>http://woculus.com/<br/>',
                        flag: '',
                        replied: true,
                        read: true,
                        attachments: false
                    },
                    {
                        id: 10,
                        sender: 'Foo Bar Joe',
                        title: 'Example#32',
                        date: '2014.04.04 12:13:10',
                        content: 'Dear John, <br/> <br/>consectetur adipiscing elit. Morbi id neque quam. Aliquam sollicitudin venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.Morbi id neque quam. Venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.<br/><br/>Best wishes,<br/><br/>Ayo Oyedotun<br/>Editor-in-Chief<br/>Woculus Inc.<br/>234-805-392-8069 ext. 12<br/>Ayo@woculus.com<br/>http://woculus.com/<br/>',
                        flag: '',
                        replied: true,
                        read: true,
                        attachments: true
                    },
                    {
                        id: 11,
                        sender: 'Joe Black',
                        title: 'Example#52',
                        date: '2014.04.04 12:13:10',
                        content: 'Dear John, <br/> <br/>consectetur adipiscing elit. Morbi id neque quam. Aliquam sollicitudin venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.Morbi id neque quam. Venenatis ipsum ac feugiat. Vestibulum ullamcorper sodales nisi nec condimentum. Mauris convallis mauris at pellentesque volutpat. Phasellus at ultricies neque, quis malesuada augue. Donec eleifend condimentum nisl eu consectetur. Integer eleifend, nisl venenatis consequat iaculis, lectus arcu malesuada sem, dapibus porta quam lacus eu neque.<br/><br/>Best wishes,<br/><br/>Ayo Oyedotun<br/>Editor-in-Chief<br/>Woculus Inc.<br/>234-805-392-8069 ext. 12<br/>Ayo@woculus.com<br/>http://woculus.com/<br/>',
                        flag: '',
                        replied: true,
                        read: true,
                        attachments: false
                    }
                ];
            };
        });
})();