Content-Type: multipart/mixed; boundary="===============0728671231183982265=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 0/2] init ahmac and port of
 mptcp_options_received
Date: Tue, 20 Oct 2020 16:39:23 -0700
Message-ID: <20201020163923.6feef9ef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: cover.1603102503.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6372

--===============0728671231183982265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2020 18:23:14 +0800 Geliang Tang wrote:
> This patchset deals with initializations of mptcp_options_received's two
> fields, ahmac and port.

Applied, but two extra comments:
 - please make sure the commit messages are in imperative form
   e.g. "Initialize x..." rather than "This patches initializes x.."
 - I dropped the Fixes tag from patch 2, and only queued patch 1 for =

   stable - patch 2 is a minor clean up, right?

Thanks!
--===============0728671231183982265==--
