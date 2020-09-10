Content-Type: multipart/mixed; boundary="===============4800654486773520694=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: call tcp_cleanup_rbuf on subflows
Date: Thu, 10 Sep 2020 16:31:16 -0700
Message-ID: <alpine.OSX.2.23.453.2009101630360.6323@pbudhkar-mobl.amr.corp.intel.com>
In-Reply-To: 90b277657a8e3bb69267f0cc902bf0d34bf32417.1599734019.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5794

--===============4800654486773520694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 10 Sep 2020, Paolo Abeni wrote:

> That is needed to let the subflows announce promply when new
> space is available in the receive buffer.
>
> tcp_cleanup_rbuf() is currently a static function, drop the
> scope modifier and add a declaration in the TCP header.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> --
> should be inserted just before "mptcp: simult flow self-tests"
>
> v1 -> v2:
> - move tcp_cleanup_rbuf() declaration inside the headers
> ---

v2 looks good for the export branch, thanks Paolo.

--
Mat Martineau
Intel
--===============4800654486773520694==--
