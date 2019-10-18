Content-Type: multipart/mixed; boundary="===============6531434035951203779=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] mptcp: recvmsg refactor follow-up
Date: Fri, 18 Oct 2019 12:22:16 +0200
Message-ID: <c57522143bb133d68fb75d1e3b5425858294563e.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1910171529130.17779@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 2236

--===============6531434035951203779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-17 at 15:31 -0700, Mat Martineau wrote:
> This looks good for merging, based on patch review and some testing.

Thank you for testing!

> I did see some KASAN problems (not associated with these patches, I =

> think), =


Can you please share the kasan report? I'm not seeing them on top of
current git.

> and lots of flushing of duplicate recv data when testing with =

> multipath-tcp.org v0.95. =


Who is flushing ?!? mptcp.org or net-next impl? if it's the latter .org
is likely too aggressive in sending retransmission (or we looks too
'lazy' as we ack at MPTCP level only after recvmsg().

Thank you,

Paolo

--===============6531434035951203779==--
