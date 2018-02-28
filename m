Content-Type: multipart/mixed; boundary="===============3120801093749262586=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 0/9] Changes for implementing MPTCP
Date: Wed, 28 Feb 2018 14:01:09 -0800
Message-ID: <d3bd8da9-5e36-4dd4-f716-da198d8f009e@oracle.com>
In-Reply-To: alpine.OSX.2.21.1802231158280.30876@gaoyuche-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 319

--===============3120801093749262586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 02/23/2018 12:20 PM, Mat Martineau wrote:
>
> On Thu, 22 Feb 2018, rao.shoaib(a)oracle.com wrote:
>
>> From: Rao Shoaib <rao.shoaib(a)oracle.com>
>>
>> Following patches modify TCP code to enable implementation of MPTCP. =

>> MPTCP implementation requires sharing of TCP code with minor =

>> modification here and there. In order to keep the TCP code clean and =

>> easy to maintain, common code has been moved to new functions for use =

>> by both TCP and MPTCP. struct tcp_sock now has function pointers and =

>> based on the socket type (TCP/MPTCP) appropriate function is called.
>>
>> A basic implementation of MPTCP that works with IPv4/IPv6 and =

>> supports join has been tested based on these changes.
>>
>> The changes are being submitted as an RFC to get feedback from the =

>> community and to start a discussion on how to move forward.
>>
>
> Hi Rao -
>
> I'd encourage you to closely read David Miller's response =

> (https://www.spinics.net/lists/netdev/msg481868.html) to the TCP-MD5 =

> RFC patch set that Christoph posted. We proposed some targeted =

> indirect calls to callbacks for handling TCP options. He said "Sorry, =

> I'm really not thrilled about this", and was focused on the =

> performance implications of those callbacks. Have you looked at the =

> performance and memory impact of adding indirection to a few dozen =

> core TCP function calls?
Yes I have. There are several papers on this subject and the jury is =

out. In the case of the frame work I have not looked at the code but =

Dave says

"I can already see in your patches that new overhead is added, new
tests in the packet building fast paths that are completely
unnecessary with the existing code, etc."

In my changes there are no new tests and fast is completely untouched. =

The only change is to call functions via a pointer instead of having =

inline. The impact of that has been a topic of discussion for a long =

time because of c++.

>
> To give some more background, when Christoph was crafting the MD5 =

> patch set I pushed to take out some static-branch code that needed =

> some work but eliminated the impact of the added callbacks for normal =

> TCP. David focused on exactly that issue and didn't dive in to other =

> aspects of the code. I can't fault him for that - he sorts through a =

> staggering volume of patches every day, and if there's an issue that's =

> clear at a glance it will pull all attention from the rest of the =

> proposal. Also consider that Christoph replied with a few more =

> questions, but the discussion stalled.
>
> I do have more to say about the proposed architecture and how to =

> structure the patch set for netdev - but I think the maintainer =

> feedback we already have about indirect callbacks is most critical to =

> consider and factor in to what we send to netdev in the future. We =

> have the shared goal to get MPTCP in to the upstream kernel and it's =

> going to take a coordinated community to get there!
I agree that it will take a co-ordinated effort but we need to know what =

upstream will accept. I have not seen any code or a detailed proposal.

I will be sending out modified MPTCP code that works with the IP changes.

What are the other issues besides the direct calls ?

Rao.

>
>
> Thanks,
> Mat
>
> -- =

> Mat Martineau
> Intel OTC


--===============3120801093749262586==--
