Content-Type: multipart/mixed; boundary="===============6283190898069420300=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 7/9] mptcp: add netlink based PM
Date: Mon, 24 Feb 2020 13:59:57 +0100
Message-ID: <254d7a6ed812076e94c59eee454474e69d2e90fc.camel@redhat.com>
In-Reply-To: bd907bec-f7ff-0ee2-82ea-ee4acfc386f4@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3747

--===============6283190898069420300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-02-22 at 17:38 +0100, Matthieu Baerts wrote:
> *Davide* : I guess no upstreamed version of ss are already using this, =

> right? Anyway because this kernel code is not upstreamed, it's not too =

> late to change, right? :)

yes, it makes sense. At a certain point, I tried to reduce the name length
as much as possible, but here _ATTR_  seems legitimate. I will send a
squash-to patch in short time.

(and I will share also the 'ss' code I'm using ATM, maybe it's also useful
for you)

thanks!
-- =

davide



--===============6283190898069420300==--
