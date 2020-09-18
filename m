Content-Type: multipart/mixed; boundary="===============0832228725196239646=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: fix integer overflow in
 mptcp_subflow_discard_data()
Date: Thu, 17 Sep 2020 18:05:08 -0700
Message-ID: <20200917.180508.408478469576670851.davem@davemloft.net>
In-Reply-To: 1a927c595adf46cf5ff186ca6b129f12fb70f492.1600375771.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5924

--===============0832228725196239646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Thu, 17 Sep 2020 23:07:24 +0200

> Christoph reported an infinite loop in the subflow receive path
> under stress condition.
> =

> If there are multiple subflows, each of them using a large send
> buffer, the delta between the sequence number used by
> MPTCP-level retransmission can and the current msk->ack_seq
> can be greater than MAX_INT.
> =

> In the above scenario, when calling mptcp_subflow_discard_data(),
> such delta will be truncated to int, and could result in a negative
> number: no bytes will be dropped, and subflow_check_data_avail()
> will try again to process the same packet, looping forever.
> =

> This change addresses the issue by expanding the 'limit' size to 64
> bits, so that overflows are not possible anymore.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/87
> Fixes: 6719331c2f73 ("mptcp: trigger msk processing even for OoO data")
> Reported-and-tested-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net-next patch, as the culprit commit is only on net-next currently

Applied, thank you.
--===============0832228725196239646==--
