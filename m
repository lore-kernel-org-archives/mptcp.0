Content-Type: multipart/mixed; boundary="===============7387686802568298535=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP-API
Date: Wed, 12 Jun 2019 14:52:39 +0200
Message-ID: <4a3390e3d110ea0e69755cddbfe9261d9958b555.camel@redhat.com>
In-Reply-To: 20190611211340.GS5495@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 1345

--===============7387686802568298535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again,

On Tue, 2019-06-11 at 14:13 -0700, Christoph Paasch wrote:
> So, we are wondering how we can do binary compatibility without having to
> wait for MPTCP to land upstream. Could the MPTCP-code expose maybe a sysc=
tl
> that indicates the "API-version" ? That way, upon startup ATS can simply
> check the API-version and if it doesn't match, just disable MPTCP.
> =

> =

> What are your thoughts?

Reporting some additional thoughts from Florian. He can't reply
directly ATM, but told me his opinion:

As far as upstream is concerned api should not change, so he is not
sure why any of the proposals would fly.  =


AF_PACKET is really a special case, we should not take inspiration from
it, and there is no no abi version in nftables as far as he knows.

Paolo (voicing Florian ;)


--===============7387686802568298535==--
