Content-Type: multipart/mixed; boundary="===============3062193906486777832=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp] mptcp: re-check dsn before reading from
 subflow
Date: Thu, 12 Mar 2020 16:12:36 -0700
Message-ID: <alpine.OSX.2.22.394.2003121535390.53592@jsingh3-mobl.amr.corp.intel.com>
In-Reply-To: 20200227083935.11585-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3938

--===============3062193906486777832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 27 Feb 2020, Florian Westphal wrote:

> mptcp_subflow_data_available() is commonly called via
> ssk->sk_data_ready(), in this case the mptcp socket lock
> cannot be acquired.
>
> Therefore, while we can safely discard subflow data that
> was already received up to msk->ack_seq, we cannot be sure
> that 'subflow->data_avail' will still be valid at the time
> userspace wants to read the data -- a previous read on a
> different subflow might have carried this data already.
>
> In that (unlikely) event, msk->ack_seq will have been updated
> and will be ahead of the subflow dsn.
>
> We can check for this condition and skip/resync to the expected
> sequence number.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> I could also submit this directly for net-next, but this
> patch is only needed w. MP_JOIN support.

I think this is ok to integrate in the topgit tree. It didn't apply =

directly due to upstream changes (sorry about the review delay) but the =

only conflict was straightforward to fix.

Thanks,

--
Mat Martineau
Intel
--===============3062193906486777832==--
