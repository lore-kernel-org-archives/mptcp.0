Content-Type: multipart/mixed; boundary="===============7956617131113815324=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] tls: Add generic NIC offload infrastructure
Date: Thu, 09 Nov 2017 11:45:02 +0900
Message-ID: <20171109024502.GD77702@Chimay.local>
X-Status: 
X-Keywords:                  
X-UID: 165

--===============7956617131113815324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Take a look at https://patchwork.ozlabs.org/patch/835816/.

TLS also needs to maintain a per-record mapping on the skb, which is similar
to the DSS-mapping.

For each TLS record, they seem to allocate a data-structure and maintain a
list of it. tls_get_record() allows to find the record based on the
sequence-number.


They seem like a good candidate for an skb_shared_info_ext :-)


I will try to find the guy who presented it here at netdev and talk to him
about it.


Christoph


--===============7956617131113815324==--
