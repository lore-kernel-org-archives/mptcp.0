Content-Type: multipart/mixed; boundary="===============8460038820703410105=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC final 00/14] Generic TCP-option framework and
 adoption for TCP-SMC and TCP-MD5
Date: Mon, 18 Dec 2017 15:33:01 -0800
Message-ID: <alpine.OSX.2.21.1712181523030.7583@mjmartin-mac01.sea.intel.com>
In-Reply-To: 20171218205528.GA64966@da0602a-dhcp135.apple.com
X-Status: 
X-Keywords:                  
X-UID: 295

--===============8460038820703410105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 18 Dec 2017, Christoph Paasch wrote:

> Hello Mat,
>
> On 18/12/17 - 12:46:59, Mat Martineau wrote:
>>
>> Christoph,
>>
>> On Sun, 17 Dec 2017, Christoph Paasch wrote:
>>
>>> Final post to the mptcp-list before submission to netdev :)
>>
>> Looks good - other than the comments I had on the framework patch earlier
>> today, I don't have any other requests.
>
> Nice! I found a little bug with racing tcp_check_req() - so I have to fix
> that. But nothing big. I will build & test once more and then submit.
>
>> Which net-next commit ID did you base the patch set on? I can push a bra=
nch
>> to git.kernel.org, but it would be best to match your git history.
>
> At the moment I'm based on c30abd5e40dd ("Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/davem/net")
> but I update regularly.
>
>
> Thanks for all your feedback!
>

And thank you for all your work refactoring, updating, and testing MD5/SMC =

and the options framework!

I pushed the commits to =

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?h=
=3Dmd5
That should trigger a build by the 0-Day test infrastructure =

(https://01.org/lkp/), which will send email if it finds issues.

--
Mat Martineau
Intel OTC

--===============8460038820703410105==--
