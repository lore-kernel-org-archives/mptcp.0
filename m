Content-Type: multipart/mixed; boundary="===============7656515306673529159=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] more performance figures
Date: Tue, 17 Dec 2019 19:18:34 +0100
Message-ID: <b3109bbee289b65cb743393e56f696a339bdc03d.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3117

--===============7656515306673529159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I was finally able to collect some performance figures on a MPTCP non
debug build (using a plain config from a somewhat notorious distro)

		TCP		MPTCP
ab 		86529.19	71504.38	(higher is better)
(100 concurrent connections)

ab		12076.22	11983.72	(higher is better)
(10000 concurrent connections)

netperf		41895.41	53244.68	(higher is better!!!)

'ab' is apache-bench, vs ngnix web server.

not sure why on plain stream transfer MPTCP apparently perform better
than plain TCP. This is for sure a test artifact, but still:

- at least we don't have tragic delta
- it's nice ;)

On a more serious side, the mesurable delta will a little number of
connection hints at the room for improvement we currently have in
mptcp_{stream_}accept().

Cheers,

Paolo



--===============7656515306673529159==--
