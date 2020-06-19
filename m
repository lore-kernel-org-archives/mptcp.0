Content-Type: multipart/mixed; boundary="===============5072824474272292184=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/4] mptcp: fallback refactor follow-up
Date: Fri, 19 Jun 2020 17:55:24 +0200
Message-ID: <508b5620-a87b-4168-852e-ca85f62a5fe2@tessares.net>
In-Reply-To: cover.1592477699.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4755

--===============5072824474272292184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat

On 18/06/2020 12:55, Paolo Abeni wrote:
> This series compraises a few followup to the fallback refactor patch.
> Ideally, they should land into the export branch just after
> "mptcp: fallback in case of simultaneous connect" - except for patch 1/4
> =

> This a v2, as patch 2/4 is the new version of the already posted
> "mptcp: check for plain TCP sock at accept time", including the changes
> suggested by Mat (M.)
> =

> Paolo Abeni (4):
>    Squash-to: "net: mptcp: improve fallback to TCP"
>    mptcp: check for plain TCP sock at accept time
>    mptcp: create first subflow at msk creation time
>    mptcp: __mptcp_tcp_fallback() returns a struct sock

Thank you for the patches and the reviews!

- 65e7483a1524: "squashed" patch 1/4 in "net: mptcp: improve fallback to =

TCP"

Patches 2/4 and 3/4 have been added after "mptcp: fallback in case of =

simultaneous connect":

- b22287584333: mptcp: check for plain TCP sock at accept time
- ba758075a064: mptcp: create first subflow at msk creation time

Note: as discussed on IRC, I modified the commit message for 3/4.

Patch 4/4 has not been accepted, discussions are still in progress.

Tests + export are in progress.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5072824474272292184==--
