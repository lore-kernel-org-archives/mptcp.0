Content-Type: multipart/mixed; boundary="===============7226547276833610967=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp v3 0/3] mptcp: plug mptcp_accept memory leaks
Date: Fri, 17 May 2019 18:23:06 +0200
Message-ID: <4390b018-94f2-45f6-dcff-2d6c95eb46b1@tessares.net>
In-Reply-To: 20190516092351.9741-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1197

--===============7226547276833610967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Thank you for the patches and the update.
And thanks Peter and Mat for the reviews!

On 16/05/2019 11:23, Florian Westphal wrote:
> v3: rebase & fix erroneous conditional in patch #3.
> =

> v2 cover letter:
> v2:
> - rename helper in patch 2
> - add back crucial mptcp_init_sock() after clone in patch 3.
>   This was lost during rebase and broke the tests but i forgot
>   to refresh this patch when i sent v1.                     =

> =

> This series resolves the memory leaks that occur when running
> mptcp_connect.sh.
> =

> I don't mind if they get squashed.
> I've decided to split this into 3 distinct changes to make it
> a bit clearer what is going on.  =


Thank you for this!

Because the 1st one was fixing a bug introduced in the patch series and
the 2nd one change the architecture, I have squashed them in different
commits. For the 3rd one, I guess it made more sense to create a
specific commit to explain the decision that you took.

Here are the details of the squashes if someone wants to see them:


Patch 1: mptcp: release mptcp socket in mptcp_close:
	2bb08839b911 =E2=86=92 squash in "mptcp: Add MPTCP socket stubs"
	419b1ecc8760 =E2=86=92 sign-off
	af1f253ddd49 =E2=86=92 conflict 1
	5a85931b0875 =E2=86=92 conflict 2
	14035afa54ce..e58d56c3bdb0 =E2=86=92 result patch 1


Patch 2: mptcp: store tcp socket, not tcp sock in subflow ctx
	278ebcdf1fcd =E2=86=92 squash in "mptcp: Associate MPTCP context with TCP =
socket"
	1cf900c3d339 =E2=86=92 sign-off
	e5fabdff04da =E2=86=92 conflict 1
	0867ab696817 =E2=86=92 conflict 2
	3f9772cce9fb =E2=86=92 squash in "mptcp: Create SUBFLOW socket for incoming
connections"
	fdf93ec159c6 =E2=86=92 sign-off
	67fb09ba1e9f =E2=86=92 conflict 3
	adb0b1e24c8e =E2=86=92 conflict 4
	9127b8ba2843 + 5ca554150c60 =E2=86=92 squash in "mptcp: Make connection_li=
st a
real list of subflows" (use the new function instead of the old one +
remove unneeded semi-colon)
	b2f24974d1b2 =E2=86=92 conflict 5
	5f525e95f57f + 907383369eab =E2=86=92 fix-up 1
	e58d56c3bdb0..be0a3d56b3bb =E2=86=92 result patch 2


Patch 3: mptcp: accept: don't leak mptcp socket structure
	a7bc3b13590e =E2=86=92 added at the end (without the updates notes, I hope=
 you
don't mind)
	be0a3d56b3bb..d90f77dd19c4 =E2=86=92 result patch 3


Cheers,
Matt

> =

> Second patch is not a bug fix, i can resend and drop it if
> the consensus is to continue using the sk->sk_socket back reference.
> =

> Third patch is a bit large due to the change in how the new mptcp
> socket is created.
> =

> See the commit messages for more details.                      =

> After these changes kmemleak doesn't report any leaks when the  =

> test script has completed.
> =

> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============7226547276833610967==--
