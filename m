Content-Type: multipart/mixed; boundary="===============7890019612322133447=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v4 00/12] DATA_FIN support
Date: Mon, 27 Jul 2020 22:00:45 +0200
Message-ID: <3082c3f5-b17d-c6a9-6966-cbf06ff97b8c@tessares.net>
In-Reply-To: 20200724011127.363638-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5330

--===============7890019612322133447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo,

On 24/07/2020 03:11, Mat Martineau wrote:
> Here is a series adding full DATA_FIN support at connection shutdown /
> close. See the patch 8 commit message for information about the
> disconnection state machine.
> =

> Self tests are passing. Have now checked interoperation with the
> mptcp_trunk branch.

Thank you for the new v4 and the reviews!

As discussed on IRC, I added these patches at the end of the export branch.

Note that I move:
- "mptcp: Add mptcp_close_state() helper"
- "mptcp: Track received DATA_FIN sequence number and add related helpers"
- "07aac58e4c66 mptcp: Add helper to process acks of DATA_FIN"
just before "mptcp: Use full MPTCP-level disconnect state machine" and =

skip these commits from the "per-commit" validation tests because new =

static functions are added without users.

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7890019612322133447==--
