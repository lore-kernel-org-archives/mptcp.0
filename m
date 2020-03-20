Content-Type: multipart/mixed; boundary="===============3075892823312051238=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Additional part 3 squash suggestion
Date: Fri, 20 Mar 2020 02:09:32 +0100
Message-ID: <1e7cca73cbe6e2256f8ab1ee36e4ca879ff13e3c.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2003191614420.3820@sugandh1-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4014

--===============3075892823312051238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-19 at 16:24 -0700, Mat Martineau wrote:
> What do you think about also squashing "mptcp: increment MIB counters in =
a =

> few places" in to the previous MIB commit? Seems like our patch count for =

> part 3 is still kind of high.

Additionally I think we could submit:

"mptcp: re-check dsn before reading from subflow" =

"sendmsg: truncate source buffer if mptcp sndbuf size was set from userspac=
e"
"subflow: check parent mptcp socket on subflow state change"

independently from part 3 (either before or later, as it fit better).

Togethar with the planned squashing, that makes 17 patches for part 3,
which I hope should be fine.

WDYT?

Paolo

--===============3075892823312051238==--
