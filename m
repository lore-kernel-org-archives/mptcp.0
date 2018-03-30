Content-Type: multipart/mixed; boundary="===============3129404550945372776=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 0/9] Changes for implementing MPTCP
Date: Fri, 30 Mar 2018 11:20:54 -0700
Message-ID: <0d6a315a-b66b-a1a8-67bf-30331120c0dd@oracle.com>
In-Reply-To: 20180327103725.GF71178@MacBook-Pro-6.lan
X-Status: 
X-Keywords:                  
X-UID: 488

--===============3129404550945372776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/27/2018 03:37 AM, Christoph Paasch wrote:
> Hello,
>
> On 22/02/18 - 15:49:52, rao.shoaib(a)oracle.com wrote:
>> From: Rao Shoaib <rao.shoaib(a)oracle.com>
>>
>> Following patches modify TCP code to enable implementation of MPTCP. MPT=
CP implementation requires sharing of TCP code with minor modification here=
 and there. In order to keep the TCP code clean and easy to maintain, commo=
n code has been moved to new functions for use by both TCP and MPTCP. struc=
t tcp_sock now has function pointers and based on the socket type (TCP/MPTC=
P) appropriate function is called.
>>
>> A basic implementation of MPTCP that works with IPv4/IPv6 and supports j=
oin has been tested based on these changes.
>>
>> The changes are being submitted as an RFC to get feedback from the commu=
nity and to start a discussion on how to move forward.
> I did a full review of the patches.
>
> Besides the details I commented on in the individual patches, I have a few
> higher-level comments:
>
> * The patchset introduces function-pointers to reduce the impact of MPTCP=
 on
>    the TCP-stack. Ignoring potential performance costs for a moment:
>
>    The patchset should show why these function-pointers are needed for an
>    MPTCP implementation. While reviewing the patches, it wasn't clear to =
me
>    Although, I can guess it because I know the MPTCP-code. However, someo=
ne
>    not familiar with MPTCP will have an even harder time to understand the
>    reason for these function pointers.
Your point is valid my bad.
>
> * Another question that should be answered in the patchset is how these
>    function pointers can be used by other TCP extensions (I am assuming t=
hat is
>    the intention). The question that arises then is how could MPTCP be sh=
ared
>    with these other TCP extensions?
What extensions -- Give me an example.
>
> * It should also be explained in the patchset how one switches the functi=
on
>    pointers. It was unclear to me how MPTCP gets enabled.
See the magic in tcp_init_sock. If unlikely(tp->op_ops->sock_init) is =

set that is where all the magic will happen. That is not part of this =

patch. If you want to see that check the MPTCP pages. This patch is only =

about refactoring TCP code so that MPTCP is less intrusive.
>
>    In tcp_init_sock() tp->op_ops is currently set to tcp_default_op_ops.
>    Thus, would that mean that MPTCP would get enabled on a system-level by
>    changing tcp_default_op_ops?
Kind of -- we simple change the pointer. MPTCP has to be compiled in and =

enabled, but eventually MPTCP will have an option to be either deployed =

system wide or just on selected sockets. That part is orthogonal and =

independent to the main TCP code that upstream is concerned about.

Please also remember our initial goal is to implement a very simple =

MPTCP implementation and we are not trying to be on par with mptcp-dev.
>
> * The patches are holding the meta-lock when processing incoming packets =
or
>    timer-events. This will trigger a lot of RCU-warnings. Adressing this =
is
>    not trivial and will require significant architectural changes.
>
I do not want any significant architectural changes. I have not seen any =

RCU warnings in my testing so I was not aware of that.=C2=A0 As I have said =

previously I will deal with them later.

Thank you for your comments. If I have not answered any comment to your =

satisfaction please raise it again.

Shoaib.


--===============3129404550945372776==--
