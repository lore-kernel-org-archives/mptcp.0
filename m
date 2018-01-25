Content-Type: multipart/mixed; boundary="===============1947889779273902129=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] TCP options framework and MD5 patch set
Date: Thu, 25 Jan 2018 14:46:00 -0800
Message-ID: <alpine.OSX.2.21.1801251418110.28492@mjmartin-mac01.sea.intel.com>
In-Reply-To: 20180125221357.GV5151@da0602a-dhcp225.apple.com
X-Status: 
X-Keywords:                  
X-UID: 298

--===============1947889779273902129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 25 Jan 2018, Christoph Paasch wrote:

> Hello Mat,
>
> On 25/01/18 - 11:41:53, Mat Martineau wrote:
>>
>> Hi Christoph -
>>
>> Thanks again for posting the RFC patch set to netdev in December. In case
>> folks on this mailing list missed it, here's the link:
>>
>> https://www.spinics.net/lists/netdev/msg472988.html
>>
>> Other than the license information change, are you considering any other
>> modifications?
>
> no, not really. I was planning to get some performance numbers. But could=
n't
> get to it because of other unrelated urgencies that took my time.
>
>> I suggest modifying the last section of the cover letter (the part start=
ing
>> with "One point of discussion...") for the next round:
>>
>> """
>> There is still work to be done to more efficiently check for extra TCP
>> options in performance-sensitive code paths. A rate-limited static key w=
ould
>> nearly eliminate overhead if no extra TCP options are in use system-wide=
, or
>> a flag in a likely-hot cache line could work well.
>>
>> For now we opted for a simple if (unlikely(!hlist_empty(...)) check.
>> """
>
> That sounds good!
>
>
> What do you suggest - should we simply resubmit the RFCs as v2 with the
> minor changes? (the timing of the first submission was probably fairly bad
> as most people were out on Christmas vacation)
>

Yes, v2 with the minor changes is the way to go. The timing should be =

better - Eric has been reviewing patches and recent RFCs in the archives =

seem to have a few replies.

I looked around the git history to see if anyone would obviously be =

interested from a TCP md5sig perspective. The only recent contributor I =

found (besides Eric) was Ivan Delalande, see commit c03fa9bcac. Maybe he =

would be good for the cc list.

--
Mat Martineau
Intel OTC

--===============1947889779273902129==--
