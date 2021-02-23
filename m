Content-Type: multipart/mixed; boundary="===============1219693575876271309=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 0/3] mptcp: misc stuff
Date: Tue, 23 Feb 2021 18:59:27 +0100
Message-ID: <cddc6eeb-4932-168c-fc61-933adb95fb8e@tessares.net>
In-Reply-To: cover.1614013455.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7924

--===============1219693575876271309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 22/02/2021 18:07, Paolo Abeni wrote:
> A bunch of patches I kept sitting in my local three for a while
> The first 2 add a few more MIBs counters, for client and error
> detection's sake.
> The last one cleans-up a bit msk->first usage.
> =

> Paolo Abeni (3):
>    mptcp: add mib for token creation fallback
>    mptcp: add active MPC mibs
>    mptcp: remove unneeded check on first subflow

Thank you for the patches and the reviews!

Just applied at the end of the tree with Mat's RvB tags:

- 126867fc6c69: mptcp: add mib for token creation fallback
- d79fd47eb3ff: mptcp: add active MPC mibs
- a067c0c19a59: mptcp: remove unneeded check on first subflow
- Results: 8d9171e1a9d2..12ba6e545134

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1219693575876271309==--
