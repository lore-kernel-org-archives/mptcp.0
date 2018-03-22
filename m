Content-Type: multipart/mixed; boundary="===============4736875411765224117=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 1/1] Add MPTCP code to work with the modified TCP
 code
Date: Thu, 22 Mar 2018 11:12:42 -0700
Message-ID: <25ef3076-b0d4-d8fc-f895-6f24db3a676e@oracle.com>
In-Reply-To: 6e15594b-0d8d-45c8-9271-2e9fdc09f71d@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 398

--===============4736875411765224117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/21/2018 02:22 PM, Rao Shoaib wrote:
>
>
> On 03/21/2018 01:18 PM, Krystad, Peter wrote:
>> Hi Rao -
>>
>> On Thu, 2018-03-01 at 12:02 -0800, Rao Shoaib wrote:
>>> On 03/01/2018 11:20 AM, Christoph Paasch wrote:
>>>> On 28/02/18 - 16:49:52, rao.shoaib(a)oracle.com wrote:
>>>>> From: Rao Shoaib <rao.shoaib(a)oracle.com>
>>>>>
>>>>> Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 include/net/mptcp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 1474 +++++++++++++++++++++
>>>>> =C2=A0=C2=A0 include/net/mptcp_v4.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 56 +
>>>>> =C2=A0=C2=A0 include/net/mptcp_v6.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 56 +
>>>>> =C2=A0=C2=A0 include/net/netns/mptcp.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 52 +
>>>>> =C2=A0=C2=A0 net/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 1 +
>>>>> =C2=A0=C2=A0 net/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 =
1 +
>>>>> =C2=A0=C2=A0 net/mptcp/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 129 ++
>>>>> =C2=A0=C2=A0 net/mptcp/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 22 +
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_balia.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 267 ++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_binder.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 487 +++++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_coupled.c=C2=A0=C2=A0=C2=A0 |=C2=A0 270 =
++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_ctrl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2981
>>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_fullmesh.c=C2=A0=C2=A0 | 1877 ++++++++++=
++++++++++++++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_input.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
2970
>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_ipv4.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 345 +++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_ipv6.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 316 +++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_ndiffports.c |=C2=A0 169 +++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_ofo_queue.c=C2=A0 |=C2=A0 177 +++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_olia.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 309 +++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_output.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1837 =
++++++++++++++++++++++++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_pm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 178 +++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_redundant.c=C2=A0 |=C2=A0 268 ++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_rr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 301 +++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 597 +++++++++
>>>>> =C2=A0=C2=A0 net/mptcp/mptcp_wvegas.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 268 ++++
>>>>> =C2=A0=C2=A0 25 files changed, 15408 insertions(+)
>>>> Please read the sections "Separate your changes" and "E-mail size"
>>>> of
>>>> process/submitting-patches.rst.
>>> If you are worried about the size than do not use it. I am not
>>> asking
>>> for review, just posting it in case someone wants to try out MPTCP
>>> with
>>> my changes.
>>>
>>
>> It seems now you are asking for a review. Can we get this as a patch
>> relative to the existing MPTCP implementation so we can see your work?
>>
>> Thanks,
>>
>> Peter.
>>
Peter I may have mis-understood your question. In case you want to see =

what was changed in MPTCP you can compare what I posted with =

mptcp_v0.91. If you want I can provide you the diff or a patch.

Shoaib.

> Hi Peter,
>
> Thanks a lot for stepping up, you are brave :-).
> Yes, I am asking for a review but only for the core networking =

> changes. I have not created a patch for MPTCP because the code is not =

> formatted properly. I have provided the MPTCP code that I used for =

> testing. The code base for MPTCP used is a little old but initially we =

> only plan to support very basic MPTCP operations. So I suggest that =

> you just use the MPTCP code that I posted. We do not intend to provide =

> an implementation that is fully compatible with the current MPTCP =

> implementation, any extra features needed will be added as needed. =

> However, I do not see any issues.
>
> Also note we do not expect this patch series to be accepted (It would =

> be great if it is :-)). We only want to start a conversation with the =

> upstream folks on the direction to take. The review I am looking for =

> are issues that would prevent TCP code to be independently enhanced, =

> impact on regular TCP performance (without MPTCP) and ease of build =

> without requiring any MPTCP file and of course readability of the =

> code. I think that is all that the upstream folks care. If something =

> else should be added to the list please suggest.
>
> The code uses function pointers as that was the most clean interface, =

> but due to the recent security issues the performance enhancements for =

> indirect branch predictions for certain CPU's have been turned off =

> (They were ON before). I am in the process of changing the code to use =

> a macro that activates when MPTCP is compiled and does a check on the =

> socket. As someone commented, function pointers are integral to =

> current software, so there will be a solution and we will revert back.
>
> Please do not hesitate to contact me.
>
> Thanks a lot,
>
> Shoaib
>
>
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============4736875411765224117==--
