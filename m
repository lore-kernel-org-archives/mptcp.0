Content-Type: multipart/mixed; boundary="===============7542721156964111465=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: be careful on MPTCP-level ack.
Date: Tue, 24 Nov 2020 19:53:10 +0100
Message-ID: <c110f036c113f3b8154c8671ce376d555b6f2b5a.camel@redhat.com>
In-Reply-To: 20201124100809.08360e4c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 6904

--===============7542721156964111465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-11-24 at 10:08 -0800, Jakub Kicinski wrote:
> On Tue, 24 Nov 2020 12:20:11 +0100 Paolo Abeni wrote:
> > -static void mptcp_send_ack(struct mptcp_sock *msk, bool force)
> > +static inline bool tcp_can_send_ack(const struct sock *ssk)
> > +{
> > +	return !((1 << inet_sk_state_load(ssk)) &
> > +	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE));
> > +}
> =

> Does the compiler really not inline this trivial static function?

whoops... That is just me adding an unneeded keyword. I'll send a v2.

Thanks,

Paolo



--===============7542721156964111465==--
