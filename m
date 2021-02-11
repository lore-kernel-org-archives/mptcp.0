Content-Type: multipart/mixed; boundary="===============1508933778031471409=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v7 mptcp-next 00/11] RM_ADDR: remove a list
 of addrs
Date: Thu, 11 Feb 2021 16:34:05 +0100
Message-ID: <70cd970f-3bc8-b604-5986-2b5e6dffa4bd@tessares.net>
In-Reply-To: e456a97f-5e6b-681d-ced0-e633b7bc3db3@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7755

--===============1508933778031471409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 10/02/2021 20:42, Mat Martineau wrote:
> On Wed, 10 Feb 2021, Geliang Tang wrote:
> =

>> v7:
>> - only changed the selftests.
>> - add patch 9 and 10 from patchset "move to next addr and testcases".
>> - drop "invalid addresses flush" in in patch 11, move it to patchset
>> "move to next addr and testcases"
>> - tag: export/20210209T062213
> =

> Geliang -
> =

> Thanks for reposting with the test changes. Self tests pass here and I =

> reviewed the pcaps and debug logs too, looks good for the export branch.

Thank you for the patches and reviews!
Just applied in our tree with Mat's RvB and 2 small typos fixed in the =

commit messages and reported by "checkpatch.pl --codespell"

- 1c96937632b9: mptcp: add rm_list in mptcp_out_options
- 3fdf49c516da: mptcp: add rm_list_tx in mptcp_pm_data
- 7aee779e6946: mptcp: add rm_list in mptcp_options_received
- 3edb9adea339: mptcp: add rm_list_rx in mptcp_pm_data
- 6eed48ec95a3: mptcp: remove multi addresses in PM
- b2144a3313f8: mptcp: remove multi subflows in PM
- 125ef24bb692: mptcp: remove multi addresses and subflows in PM
- bb2f562e7c86: mptcp: remove a list of addrs when flushing
- 0a0186b2d7b2: selftests: mptcp: add invert argument for chk_rm_nr
- 12f49b51c3de: selftests: mptcp: set addr id for removing testcases
- 9373d5c3f215: selftests: mptcp: add testcases for removing addrs
- Results: 312a753c50d7..d5fb4935cee8

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1508933778031471409==--
