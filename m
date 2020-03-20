Content-Type: multipart/mixed; boundary="===============4177622068170185879=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/3] MP_JOIN self-tests fixes
Date: Fri, 20 Mar 2020 16:11:29 +0100
Message-ID: <0bec23ecaa2f63f26cc19237963dbbd114a5feeb.camel@redhat.com>
In-Reply-To: d6f19bdb2f5299871bb0dff73b2bba30467fc971.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4018

--===============4177622068170185879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-19 at 23:54 +0100, Paolo Abeni wrote:
> On Thu, 2020-03-19 at 23:45 +0100, Paolo Abeni wrote:
> > Also, with a quick too into the captured pcap trace, I think the ipv4
> > address inside add_Addr option is not initialized.
> > =

> > I'll try to double check.
> =

> Nope, it's just a wireshark bug (it looks like there is no correct
> mptcp v1 add_addr support in wireshark, but that is a topic for later).

Well, actually such support is already there, thanks to Peter! my local
wireshark build was a bit outdated.

Many thanks, Peter!

/P

--===============4177622068170185879==--
