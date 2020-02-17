Content-Type: multipart/mixed; boundary="===============0620530040078176927=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 5/6] mptcp: protocol: re-check dsn before
 reading from subflow
Date: Mon, 17 Feb 2020 19:56:42 +0100
Message-ID: <10c4f37dbe59967dd5073a7b6813c25ced983fc9.camel@redhat.com>
In-Reply-To: 20200217150101.13603-6-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3686

--===============0620530040078176927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-17 at 16:01 +0100, Florian Westphal wrote:
> mptcp_subflow_data_available() is commonly called via
> ssk->sk_data_ready(), in this case the mptcp socket lock
> cannot be acquired.
> =

> Therefore, while we can safely discard subflow data that
> was already received up to msk->ack_seq, we cannot be sure
> that 'subflow->data_avail' will still be valid at the time
> userspace wants to read the data -- a previous read on a
> different subflow might have carried this data already.
> =

> In that (unlikely) event, msk->ack_seq will have been updated
> and will be ahead of the subflow dsn.

Does the above mean that we can get wake-up events and found no actual
data in the msk socket? (read will block)

Something alike:
- user space is blocked on mptcp_recvmsg()/mptcp_wait_data() ->
wait_data =3D=3D true
- subflow 1 delivers new in order data, wakes the user space which
start reading
- before mptcp_recvmsg updates the msk->ack_seq, subflow 2 delivers the
same DSS as subflow 1, consider that to be in order and sets the
MPTCP_DATA_READY bit
- mptcp_recvmsg fills the user-space buffer and completes. Since
wait_data =3D=3D true, the MPTCP_DATA_READY bit is left untouched.
- next mptcp_poll will return EPOLLIN even if no data is really
available.

Should we move the 'wait_data =3D false' initialization inside some inner
loop?

Thanks,

Paolo

--===============0620530040078176927==--
