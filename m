Content-Type: multipart/mixed; boundary="===============3077483598839210702=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: Initialize map_seq upon subflow
 establishment
Date: Tue, 12 May 2020 12:09:11 -0700
Message-ID: <20200512.120911.2258216308785425487.davem@davemloft.net>
In-Reply-To: 6b0594845f7787b9bc82c845321e23b6bc3bca38.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4374

--===============3077483598839210702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Mon, 11 May 2020 19:35:21 +0200

> On Mon, 2020-05-11 at 09:24 -0700, Christoph Paasch wrote:
>> When the other MPTCP-peer uses 32-bit data-sequence numbers, we rely on
>> map_seq to indicate how to expand to a 64-bit data-sequence number in
>> expand_seq() when receiving data.
>> =

>> For new subflows, this field is not initialized, thus results in an
>> "invalid" mapping being discarded.
>> =

>> Fix this by initializing map_seq upon subflow establishment time.
>> =

>> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
>> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
 ...
> Reviewed-by: Paolo Abeni <pabeni(a)redhat.com>

Applied, thanks.
--===============3077483598839210702==--
