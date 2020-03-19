Content-Type: multipart/mixed; boundary="===============1691536857526317335=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/3] MP_JOIN self-tests fixes
Date: Thu, 19 Mar 2020 23:45:17 +0100
Message-ID: <07fb93ff4494094a7a5ca2dec204a9a935335454.camel@redhat.com>
In-Reply-To: 3ef23261-371e-4b04-8b08-dd7e4187b9c8@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3996

--===============1691536857526317335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-19 at 22:29 +0100, Matthieu Baerts wrote:
> On 19/03/2020 18:58, Matthieu Baerts wrote:> On 16/03/2020 19:06, Paolo =

> Abeni wrote:
> =

> (...)
> =

> > Thank you for the patches and the reviews!
> > =

> > - c4615f515b41: "squashed" patch 1/3 in "mptcp: Implement path manager =

> > interface commands"
> > - 5257c21d9804: conflict in =

> > t/mptcp-implement-and-use-MPTCP-level-retransmission
> > - b2fc8ed9ca5f: conflict in t/mptcp-add-netlink-based-PM
> > - ca158067259a..ef5d4d25c399: result
> > =

> > - a49945862c4d: "squashed" patch 2/3 in "mptcp: add netlink based PM"
> > - ef5d4d25c399..152845a286fa: result
> > =

> > - 89d9a90d57ec: "squashed" patch 3/3 in "selftests: add test-cases for =

> > MPTCP MP_JOIN"
> > - 152845a286fa..6854e267eb38: result
> > =

> > Tests + export are in progress.
> =

> I don't know if it is because of this series of the previous one (I =

> didn't validate the ADD_ADDRv1 series because of the compilation errors =

> without IPv6) but MP-JOIN selftests are not passing:

[...]

I think it's due to:

mptcp: v1 ADD_ADDR changes: options and parsing

which stripped (I think unintentionally) a couple of:

	 mp_opt->add_addr =3D 1;

so the client never get notifed of incoming address

Also, with a quick too into the captured pcap trace, I think the ipv4
address inside add_Addr option is not initialized.

I'll try to double check.

/P

--===============1691536857526317335==--
