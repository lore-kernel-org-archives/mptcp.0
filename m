Content-Type: multipart/mixed; boundary="===============1367822037146392410=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net v2 0/5] mptcp: fix incoming options parsing
Date: Thu, 30 Apr 2020 12:23:50 -0700
Message-ID: <20200430.122350.1535307324828560479.davem@davemloft.net>
In-Reply-To: cover.1588243786.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4291

--===============1367822037146392410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Thu, 30 Apr 2020 15:01:50 +0200

> This series addresses a serious issue in MPTCP option parsing.
> =

> This is bigger than the usual -net change, but I was unable to find a
> working, sane, smaller fix.
> =

> The core change is inside patch 2/5 which moved MPTCP options parsing from
> the TCP code inside existing MPTCP hooks and clean MPTCP options status on
> each processed packet.
> =

> The patch 1/5 is a needed pre-requisite, and patches 3,4,5 are smaller,
> related fixes.
> =

> v1 -> v2:
>  - cleaned-up patch 1/5
>  - rebased on top of current -net

Series applied, thanks.
--===============1367822037146392410==--
