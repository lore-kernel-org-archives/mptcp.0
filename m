Content-Type: multipart/mixed; boundary="===============1565180515126725459=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp] mptcp: re-check dsn before reading from
 subflow
Date: Fri, 13 Mar 2020 23:39:22 +0100
Message-ID: <4b74a42b-de17-f2eb-bca0-436ec47c1621@tessares.net>
In-Reply-To: alpine.OSX.2.22.394.2003121535390.53592@jsingh3-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3943

--===============1565180515126725459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 13/03/2020 00:12, Mat Martineau wrote:
> =

> On Thu, 27 Feb 2020, Florian Westphal wrote:
> =

>> mptcp_subflow_data_available() is commonly called via
>> ssk->sk_data_ready(), in this case the mptcp socket lock
>> cannot be acquired.
>>
>> Therefore, while we can safely discard subflow data that
>> was already received up to msk->ack_seq, we cannot be sure
>> that 'subflow->data_avail' will still be valid at the time
>> userspace wants to read the data -- a previous read on a
>> different subflow might have carried this data already.
>>
>> In that (unlikely) event, msk->ack_seq will have been updated
>> and will be ahead of the subflow dsn.
>>
>> We can check for this condition and skip/resync to the expected
>> sequence number.
>>
>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
>> ---
>> I could also submit this directly for net-next, but this
>> patch is only needed w. MP_JOIN support.
> =

> I think this is ok to integrate in the topgit tree.

Thank you for the patch and the review!

I just added this patch at the end of the series, as a new commit =

(t/mptcp-re-check-dsn-before-reading-from-subflow).

Was it what you had in mind? I can easily move it somewhere else if needed.

> It didn't apply =

> directly due to upstream changes (sorry about the review delay) but the =

> only conflict was straightforward to fix.
Indeed, I had one conflict, simple to resolve.

Tests are successful and the "export" has been updated.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1565180515126725459==--
