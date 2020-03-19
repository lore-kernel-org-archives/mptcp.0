Content-Type: multipart/mixed; boundary="===============5761162760461208794=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/3] MP_JOIN self-tests fixes
Date: Thu, 19 Mar 2020 23:54:48 +0100
Message-ID: <d6f19bdb2f5299871bb0dff73b2bba30467fc971.camel@redhat.com>
In-Reply-To: 07fb93ff4494094a7a5ca2dec204a9a935335454.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3998

--===============5761162760461208794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-19 at 23:45 +0100, Paolo Abeni wrote:
> Also, with a quick too into the captured pcap trace, I think the ipv4
> address inside add_Addr option is not initialized.
> =

> I'll try to double check.

Nope, it's just a wireshark bug (it looks like there is no correct
mptcp v1 add_addr support in wireshark, but that is a topic for later).
I'll cook a patch for the missing add_addr.

Cheers,

Paolo


--===============5761162760461208794==--
