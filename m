Content-Type: multipart/mixed; boundary="===============4598153161838643207=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/3] mptcp: add MPTCP socket diag interface
Date: Fri, 26 Jun 2020 12:33:31 +0200
Message-ID: <796242d444a52afeaed649affb6a2401aa43c48c.camel@redhat.com>
In-Reply-To: b5032e6de38e68ce506c8ce7f5ee2ba9eef685a3.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4816

--===============4598153161838643207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-06-26 at 09:53 +0200, Paolo Abeni wrote:
> I can replace 'can_ack' and 'fallback' with a 32bit flags. =


I support this: in the future we might want to add additinal states to
control TCP fallback (specifically, add the possibility to disallow it)

> Perhaps I can use a better name for the first bit (suggestion welcome!) I
> would opt for 'remote_key', WDYT?

this variable becomes true when it's possible to use the 64-bit key
received by the peer, generate the DACK4 / DACK8 number (probably it's
used also for other purposes, right?) if so, what about 'remote_key_valid'
?

thanks!
-- =

davide



--===============4598153161838643207==--
