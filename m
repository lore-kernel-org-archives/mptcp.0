Content-Type: multipart/mixed; boundary="===============0559534882091320745=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v8 mptcp-next 0/8] Add REMOVE_ADDR support
Date: Tue, 01 Sep 2020 18:02:11 +0200
Message-ID: <3717e7b40a029e1e5e5cd343af74d6f702e721d2.camel@redhat.com>
In-Reply-To: cover.1598267961.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5683

--===============0559534882091320745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-08-24 at 19:36 +0800, Geliang Tang wrote:
> v8:
>  - drop anno_list in v7.
>    We don't need to add a new list, conn_list is enough for the signal
> address and local subflow.

I think this could be problematic.

An MPTCP socket could refuse or delay the creation of new subflows for
addresses received via ADD_ADDR. =


But an MPTCP should send REMOVE_ADDR for accounced addresses, even if
no subflows exists on top of them.

Removing the anno_list we lose this ability.

I'd like to avoid additional interations, if possible, and eventually
add squash-to fixes if/where needed. Other options more than welcome.

Cheers,

Paolo

--===============0559534882091320745==--
