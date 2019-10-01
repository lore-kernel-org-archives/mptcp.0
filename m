Content-Type: multipart/mixed; boundary="===============0733740841612060423=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] mptcp: add MIB counters
Date: Tue, 01 Oct 2019 10:26:55 -0700
Message-ID: <alpine.OSX.2.21.1910011026270.22340@syitbare-mobl.amr.corp.intel.com>
In-Reply-To: 20190930145158.5331-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1960

--===============0733740841612060423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 30 Sep 2019, Florian Westphal wrote:

> As mentioned earlier, here is v2 of the MIB counter patch set.
>
> I've tossed all counters that aren't used (=3D have no spot that
> increments them).
>
> Tests still pass, counters get incremented, you can show them
> via 'nstat' or "netststat -s".
>

Thanks for the updated patches, Florian. v2 looks good to me.

--
Mat Martineau
Intel
--===============0733740841612060423==--
