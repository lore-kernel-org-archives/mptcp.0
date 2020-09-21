Content-Type: multipart/mixed; boundary="===============4441239528400209855=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] mptcp: add ADD_ADDR IPv6
 support
Date: Mon, 21 Sep 2020 13:12:22 +0200
Message-ID: <20200921111222.GA27188@breakpoint.cc>
In-Reply-To: aa214a833e31f406fe542366a56198d6edc91fd9.1600608822.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5961

--===============4441239528400209855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliangtang(a)gmail.com> wrote:
> When ADD_ADDR suboption include an IPv6 address, the size is 28 octets.
> It will not fit when other options are included, e.g. TCP Timestamps. So
> here we send out a mptcp dedicated packet to carry only mptcp options.

Note that RFC 7323 requires TCP TS to be included for the remainder of
the connection.  It even recommends TCP peers to drop segments that do
not carry a timestamp option in case the connection has TCP TS enabled.
--===============4441239528400209855==--
