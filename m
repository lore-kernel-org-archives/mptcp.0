Content-Type: multipart/mixed; boundary="===============3052419199576407809=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 0/9] Changes for implementing MPTCP
Date: Wed, 28 Feb 2018 14:57:08 -0800
Message-ID: <8c03e117-1f20-656d-8f0e-af279abf70c1@oracle.com>
In-Reply-To: 20180228223235.GA15661@MacBook-Pro-4.local
X-Status: 
X-Keywords:                  
X-UID: 323

--===============3052419199576407809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Christoph,

On 02/28/2018 02:32 PM, Christoph Paasch wrote:
>
>>> Hi Rao -
>>>
>>> I'd encourage you to closely read David Miller's response
>>> (https://www.spinics.net/lists/netdev/msg481868.html) to the TCP-MD5 RFC
>>> patch set that Christoph posted. We proposed some targeted indirect
>>> calls to callbacks for handling TCP options. He said "Sorry, I'm really
>>> not thrilled about this", and was focused on the performance
>>> implications of those callbacks. Have you looked at the performance and
>>> memory impact of adding indirection to a few dozen core TCP function
>>> calls?
>> Yes I have. There are several papers on this subject and the jury is out=
. In
>> the case of the frame work I have not looked at the code but Dave says
>>
>> "I can already see in your patches that new overhead is added, new
>> tests in the packet building fast paths that are completely
>> unnecessary with the existing code, etc."
>>
>> In my changes there are no new tests and fast is completely untouched. T=
he
>> only change is to call functions via a pointer instead of having inline.=
 The
>> impact of that has been a topic of discussion for a long time because of
>> c++.
> The problem is in patch 5/9. For example, the change in
> __tcp_push_pending_frames.
>
> Accessing the function-pointer makes two memory-accesses which potentially
> can have a cache-miss.
>
> That's the fast-path cost that upstream is worried about.
Anything can cause a cache miss, the code for the function may not be =

there. If this is a fast path, the chances are very likely everything =

will be in the CPU cache. I have to look at the options framework on =

which all these comments are based on.
>
>>> To give some more background, when Christoph was crafting the MD5 patch
>>> set I pushed to take out some static-branch code that needed some work
>>> but eliminated the impact of the added callbacks for normal TCP. David
>>> focused on exactly that issue and didn't dive in to other aspects of the
>>> code. I can't fault him for that - he sorts through a staggering volume
>>> of patches every day, and if there's an issue that's clear at a glance
>>> it will pull all attention from the rest of the proposal. Also consider
>>> that Christoph replied with a few more questions, but the discussion
>>> stalled.
>>>
>>> I do have more to say about the proposed architecture and how to
>>> structure the patch set for netdev - but I think the maintainer feedback
>>> we already have about indirect callbacks is most critical to consider
>>> and factor in to what we send to netdev in the future. We have the
>>> shared goal to get MPTCP in to the upstream kernel and it's going to
>>> take a coordinated community to get there!
>> I agree that it will take a co-ordinated effort but we need to know what
>> upstream will accept. I have not seen any code or a detailed proposal.
>>
>> I will be sending out modified MPTCP code that works with the IP changes.
>>
>> What are the other issues besides the direct calls ?
> The list of function pointers is huge.
>
> If we post this on netdev, it won't cast a good light on the MPTCP
> upstreaming effort. DaveM wants the design to fit neatly into the TCP-sta=
ck
> with minimal/zero performance impact.
That is not exactly correct. When we talked to them they were willing to =

accept some regression. Also I recently exchanged some email with them =

about how to submit a patch in which I did mention I was using pointers, =

I did not hear an concern. All they said was submit the patch and lets =

us look at the code.
>
> We have to try to achieve that before we post on netdev.
Well how do we determine that ?

>
>
> The problem is also that the patches don't provide any context to netdev
> as to why this is needed (e.g., why is a function-pointer for tcp_urg
> needed?). Without the context, it will be hard for people to provide
> feedback.
That is fine. Let the community reject the patch. I see no harm in =

asking the community. I am ready for my patch to be rejected, but what =

if they say yes fine ?

Shoaib
>
>
> Christoph
>


--===============3052419199576407809==--
