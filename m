Content-Type: multipart/mixed; boundary="===============0594579238784057146=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: kbuild is working again, found a failure
Date: Mon, 15 Mar 2021 15:49:16 +0800
Message-ID: <CA+WQbwsSPEQt9=ucOr4eHwJWt2Z1MmarNXWtzvshirHO4GVUWQ@mail.gmail.com>
In-Reply-To: 885b44af-ca88-bea8-c824-f5cc8a89e2d@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8156

--===============0594579238784057146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Matt,

I had reproduced this failure. So I created a new issue #173 "remove
invalid addresses testcase fail" to trace it.

I had assigned this issue to myself, and I'll try to fix it recently.

Thanks.

-Geliang

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=B4=
3=E6=9C=8813=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=883:19=E5=86=99=E9=
=81=93=EF=BC=9A
>
>
> Hello -
>
> Thanks Matthieu for adding the "static_call: Fix the module key fixup"
> commit to the mptcp_net-next repository, the kbuild tests are now running
> again.
>
> There was a failure in mptcp_join.sh:
>
> user  :notice: [  380.427338] # 24 remove invalid addresses             s=
yn[ ok ] - synack[ ok ] - ack[ ok ]
> user  :notice: [  380.456500] #                                         a=
dd[ ok ] - echo  [ ok ]
> user  :notice: [  380.472445] #                                         r=
m [fail] got 2 RM_ADDR[s] expected 3
> user  :notice: [  380.488441] #  - sf    [ ok ]
> user  :notice: [  380.493351] # Server ns stats
> user  :notice: [  380.499668] # MPTcpExtMPCapableSYNRX          1        =
          0.0
> user  :notice: [  380.508705] # MPTcpExtMPCapableACKRX          1        =
          0.0
> user  :notice: [  380.518042] # MPTcpExtMPJoinSynRx             1        =
          0.0
> user  :notice: [  380.527101] # MPTcpExtMPJoinAckRx             1        =
          0.0
> user  :notice: [  380.536145] # MPTcpExtEchoAdd                 3        =
          0.0
> user  :notice: [  380.545105] # MPTcpExtRmSubflow               1        =
          0.0
> user  :notice: [  380.553759] # Client ns stats
> user  :notice: [  380.559474] # MPTcpExtMPCapableSYNTX          1        =
          0.0
> user  :notice: [  380.568482] # MPTcpExtMPCapableSYNACKRX       1        =
          0.0
> user  :notice: [  380.577496] # MPTcpExtMPJoinSynAckRx          1        =
          0.0
> user  :notice: [  380.586552] # MPTcpExtAddAddr                 3        =
          0.0
> user  :notice: [  380.595546] # MPTcpExtRmAddr                  2        =
          0.0
>
> --
> Mat Martineau
> Intel
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============0594579238784057146==--
