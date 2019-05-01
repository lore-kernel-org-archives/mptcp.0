Content-Type: multipart/mixed; boundary="===============4668227644200897341=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP architecture proposal - RFCv10 changes pushed
Date: Wed, 01 May 2019 15:45:00 -0700
Message-ID: <alpine.OSX.2.21.1905011543050.31178@mjkendri-mobl1.amr.corp.intel.com>
In-Reply-To: alpine.OSX.2.21.1904291616570.5723@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 1108

--===============4668227644200897341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 29 Apr 2019, Mat Martineau wrote:

>
> Hello -
>
> I have pushed an update to the MPTCP kernel architecture proposal:
>
> https://review.gerrithub.io/q/project:multipath-tcp%252Fmptcp_net-next+st=
atus:open
>
> https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?=
h=3Dmptcp-proposal
>
>
> The commit ID for RFCv10 is 6cfe3336cf01a64e45d66124f3ff768cab0df1bd

I pushed Florian's selftest-with-netns+veth commit to both repositories. =

New head is c65dbcf9330297a4170fae4daf03aa5847b2955a


Mat


>
>
> Changes:
>
> 1) Split the mptcp.h header file
>
> 2) Refined handling CONFIG_MPTCP vs non-CONFIG_MPTCP builds
>
> 3) Refactored option writing code to minimize changes in tcp_output.c and =

> avoid using magic numbers
>
> 4) Added ULP clone hook and modified MPTCP subflow cloning to use it
>
> 5) Florian's namespacing fix and conn_finished fix (rx dst update crash)
>
> 6) Fix locking in mptcp_recvmsg()
>
>
> Regards,
>
> --
> Mat Martineau
> Intel
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============4668227644200897341==--
