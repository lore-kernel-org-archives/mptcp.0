Content-Type: multipart/mixed; boundary="===============8697628236176441350=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2] mptcp: Make MPTCP socket block/wakeup ignore
 sk_receive_queue
Date: Thu, 22 Aug 2019 19:00:26 +0200
Message-ID: <942c5b1801d6ffc6afa07cc52bbcefa6b03b5983.camel@redhat.com>
In-Reply-To: 20190803001637.25724-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1677

--===============8697628236176441350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-02 at 17:16 -0700, Mat Martineau wrote:
> The MPTCP-level socket doesn't use sk_receive_queue, so it was possible
> for mptcp_recvmsg() to remain blocked when there was data ready for it
> to read. When the MPTCP socket is waiting for additional data and it
> releases the subflow socket lock, the subflow may have incoming packets
> ready to process and it sometimes called subflow_data_ready() before the
> MPTCP socket called sk_wait_data().
> =

> This change adds a new function for the MPTCP socket to use when waiting
> for a data ready signal. Atomic bitops with memory barriers are used to
> set, test, and clear a MPTCP socket flag that indicates waiting subflow
> data. This flag replaces the sk_receive_queue checks used by other
> socket types.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

(sorry for lagging behind so much)

The patch LGTM, but I have some related questions: how do you reproduce
the issue fixed here? can we add that to the self-tests? (I assume/sort
of recall the patch fix the issue in your scenario).

Thanks,

Paolo


--===============8697628236176441350==--
