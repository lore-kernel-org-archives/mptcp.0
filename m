Content-Type: multipart/mixed; boundary="===============5138950077954547908=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v9 mptcp-next 0/9] ADD_ADDR: ports support
Date: Sat, 09 Jan 2021 09:58:58 +0800
Message-ID: <CA+WQbwsjxB8RMGOjgWWsfBD-T=p8bDu5ymXMJ-di45teZwrjjg@mail.gmail.com>
In-Reply-To: 972f77ce-f994-53d6-fc70-7c692da97021@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7302

--===============5138950077954547908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=B4=
1=E6=9C=889=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=887:19=E5=86=99=E9=
=81=93=EF=BC=9A
>
>
> On Tue, 5 Jan 2021, Geliang Tang wrote:
>
> > v9:
> > - use queue_rcu_work to release the listening socket.
> > - squash v8's patch 2 with patch 3.
> > - add two new patches, "mptcp: drop unused skb in
> > subflow_token_join_request" and "mptcp: add a new helper
> > subflow_req_create_thmac"
> >
>
> Hi Geliang -
>
> I'd like to make a request to make review easier: Please include in the
> cover letter the base commit where the patches apply successfully, or a
> reference to a public git repo showing the full commit history. It took
> some trial and error to figure out that this patch set only applied on top
> of the export branch with the "add-IPv4-mapped address support v4" patch
> set applied too.
>
> For example, referencing the export tag from the mptcp_net-next repo (like
> export/20201217T083536) and the patch set name and revision for any
> prerequisite patch sets would really help.

Sorry for the trouble, I just sent my commit log to you.

Thanks.

-Geliang

>
> Thanks!
>
> --
> Mat Martineau
> Intel
--===============5138950077954547908==--
