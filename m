Content-Type: multipart/mixed; boundary="===============7505888095225619444=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 1/7] mptcp: pm: add lockdep assertions
Date: Tue, 19 Jan 2021 16:24:53 -0800
Message-ID: <15c5722-f325-a6ac-197c-77364993e9b@linux.intel.com>
In-Reply-To: 20210114173654.7618-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7430

--===============7505888095225619444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 14 Jan 2021, Florian Westphal wrote:

> Add a few assertions to make sure functions are called with the needed
> locks held.
> Two functions gain might_sleep annotations because they contain condition=
al
> calls to functions that sleep.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/pm.c         |  2 ++
> net/mptcp/pm_netlink.c | 13 +++++++++++++
> net/mptcp/protocol.c   |  4 ++++
> net/mptcp/protocol.h   |  5 +++++
> 4 files changed, 24 insertions(+)
>

These annotations look good - I think it would be good to apply this in =

the export branch now, like you noted in the cover letter.

--
Mat Martineau
Intel
--===============7505888095225619444==--
