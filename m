Content-Type: multipart/mixed; boundary="===============7564731126154686022=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: call tcp_cleanup_rbuf on subflows
Date: Wed, 09 Sep 2020 18:08:17 -0700
Message-ID: <alpine.OSX.2.23.453.2009091713540.4909@atenciom-mobl1.amr.corp.intel.com>
In-Reply-To: 396a39fddc546f5d97cd42c59db565428cdc120a.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5777

--===============7564731126154686022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Sep 2020, Paolo Abeni wrote:

> On Wed, 2020-09-09 at 15:51 +0200, Paolo Abeni wrote:
>> That is needed to let the subflows announce promply when new
>> space is available in the receive buffer.
>>
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> --
>
> Reporting here info shared on the IRC channel.
>
> This is a bit rough,

(like the new tcp_cleanup_rbuf declaration?)

> but fixes the simult self-tests (at least the
> enabled one) and here apparently also reduces the mptcp_connect.sh
> self-tests run time.
>
> Any third-party confirm more than appreciated ;)
>

Looks like a good idea to me. mptcp_connect.sh seems faster, and the =

"balanced bwidth with unbalanced delay" simult test passes.

--
Mat Martineau
Intel
--===============7564731126154686022==--
