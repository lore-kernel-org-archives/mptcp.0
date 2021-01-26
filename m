Content-Type: multipart/mixed; boundary="===============6862495624170315171=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 0/5] mptcp: netlink event support
Date: Tue, 26 Jan 2021 21:28:31 +0100
Message-ID: <6f6e3829-5b4b-bace-7cc1-d783df761dd0@tessares.net>
In-Reply-To: 5cedb15c-d3f0-be9d-b821-de9c79411f9@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7493

--===============6862495624170315171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 26/01/2021 18:01, Mat Martineau wrote:
> =

> On Wed, 20 Jan 2021, Florian Westphal wrote:
> =

>> This is round 2 of the netlink event series.
>> No changes here except in patch 4 (minor checkpatch format nit)
>> and patch 5.
> =

> Just clarifying tags after my reply to the patch 5 thread, Matthieu =

> please tag patches 1, 2, 3, and 5 with:
> =

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> =

> (patch 4 tag is different, in a separate email)

Thank you for the patches and the series!

Just applied to our tree with the RvB and Acked-by tags, the =

modification of the group (mptcp_pm_events) and a micro checkpatch =

format nit (blank line after enum like the previous ones in mptcp.h).

- 57b1e8d7873c: mptcp: split __mptcp_close_ssk helper
- 37f87493bc63: mptcp: pass subflow socket to a few helpers
- 5e2330f127b5: mptcp: avoid lock_fast usage in accept path
- edd4b6f8f6ac: genetlink: add CAP_NET_ADMIN test for multicast bind
- f15cd5fd4c26: mptcp: add netlink event support
- Results: de7588363638..daa6a08b00eb

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6862495624170315171==--
