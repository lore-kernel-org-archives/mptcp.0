Content-Type: multipart/mixed; boundary="===============7229730028195641566=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: more DATA FIN fixes
Date: Tue, 06 Oct 2020 06:07:44 -0700
Message-ID: <20201006.060744.1614882032086190689.davem@davemloft.net>
In-Reply-To: 359280012491ffc587afdfb55aaaec60953c7218.1601891999.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6218

--===============7229730028195641566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Mon,  5 Oct 2020 12:01:06 +0200

> Currently data fin on data packet are not handled properly:
> the 'rcv_data_fin_seq' field is interpreted as the last
> sequence number carrying a valid data, but for data fin
> packet with valid maps we currently store map_seq + map_len,
> that is, the next value.
> =

> The 'write_seq' fields carries instead the value subseguent
> to the last valid byte, so in mptcp_write_data_fin() we
> never detect correctly the last DSS map.
> =

> Fixes: 7279da6145bb ("mptcp: Use MPTCP-level flag for sending DATA_FIN")
> Fixes: 1a49b2c2a501 ("mptcp: Handle incoming 32-bit DATA_FIN values")
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied.
--===============7229730028195641566==--
