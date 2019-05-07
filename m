Content-Type: multipart/mixed; boundary="===============4594598931247744904=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: Add capture option
Date: Tue, 07 May 2019 15:01:09 +0200
Message-ID: <e9c4f615d1119ade8b1ceed5d38c6057b53ad6b3.camel@redhat.com>
In-Reply-To: 99ffcaab-e114-5ba5-0d8a-fcea5fe303ed@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1117

--===============4594598931247744904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-05-07 at 14:47 +0200, Matthieu Baerts wrote:
> Does this patch look good to you?

Yep! Thanks for doing this.

On a side note, running tcpdump in background usually hides most of the
existing races, at least in my experiments :(

> If it is OK for you, can I append it at the end of the series or do you
> want me to squash it in another commit?

I'm fine either way, too.

Cheers,

Paolo


--===============4594598931247744904==--
