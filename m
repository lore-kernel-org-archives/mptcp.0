Content-Type: multipart/mixed; boundary="===============4388556394272222979=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] mptcp: add MIB counters
Date: Tue, 01 Oct 2019 18:11:30 +0200
Message-ID: <586ba632b0bf7bd8fdb0b582a2782120ed4cafeb.camel@redhat.com>
In-Reply-To: 20190930145158.5331-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1956

--===============4388556394272222979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2019-09-30 at 16:51 +0200, Florian Westphal wrote:
> As mentioned earlier, here is v2 of the MIB counter patch set.
> =

> I've tossed all counters that aren't used (=3D have no spot that
> increments them).
> =

> Tests still pass, counters get incremented, you can show them
> via 'nstat' or "netststat -s".

Thanks Florian, the patches LGTM!

/P

--===============4388556394272222979==--
