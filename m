Content-Type: multipart/mixed; boundary="===============2927155988863885044=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 0/2] mptcp: some fallback fixes
Date: Sat, 10 Oct 2020 11:13:32 -0700
Message-ID: <20201010111332.3ac29a5f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: cover.1602262630.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6283

--===============2927155988863885044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri,  9 Oct 2020 18:59:59 +0200 Paolo Abeni wrote:
> pktdrill pointed-out we currently don't handle properly some
> fallback scenario for MP_JOIN subflows
> =

> The first patch addresses such issue.
> =

> Patch 2/2 fixes a related pre-existing issue that is more
> evident after 1/2: we could keep using for MPTCP signaling
> closed subflows.

Applied, thanks Paolo.

You already have a few of those in the code, but:

+	if (... &&
+	    schedule_work(&mptcp_sk(sk)->work))
+		sock_hold(sk);

isn't this a fairly questionable construct?

You take a reference for the async work to release _after_ you
scheduled the async work?=20
--===============2927155988863885044==--
