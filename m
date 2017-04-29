Content-Type: multipart/mixed; boundary="===============8743720866068770395=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Change to remove MPTCP members from tcp_skb_cb
Date: Sat, 29 Apr 2017 01:10:15 -0700
Message-ID: <0a5d849e-8095-e176-ad5b-8548bebd3748@oracle.com>
In-Reply-To: 4b010288-b6ba-93c2-5729-55ac8bbc9c9a@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 23

--===============8743720866068770395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/28/2017 09:03 PM, Rao Shoaib wrote:
>>> On the rx side, overwriting the network or mac headers doesn't seem =

>>> right - what if the skb was cloned for monitoring purposes? =

>> This is a valid concern -- let me think about it a little bit. Where =

>> would the buffer be cloned ?
> Oh I just realized, I sent out a pcap file while doing mostly Rx =

> traffic. I did not see any corruption so I am not sure this is an =

> issue. To be sure I would have to dig into the code as to what happens =

> when the promiscuous mode is on.
>
> Rao. =


The reason I did not see any corruption on received packets is because =

on Rx the skb allocated has extra head room. NET_IP_ALIGN can be zero =

but NET_SKB_PAD is not. So using space right below head is just fine =

because by the time the packet reaches MPTCP the space is not being =

used. So it turns out that what is being done for MPTCP on the Tx side =

is already happening on the Rx side.

While we look at other better solutions I may send this patch to the =

mptcp-dev mailing list to get more comments as I may be overlooking some =

other issues as well.

Rao.

struct sk_buff *__napi_alloc_skb(struct napi_struct *napi, unsigned int len,
                                  gfp_t gfp_mask)
{
         struct napi_alloc_cache *nc =3D this_cpu_ptr(&napi_alloc_cache);
         struct sk_buff *skb;
         void *data;

         len +=3D NET_SKB_PAD + NET_IP_ALIGN;

<.............>

skb_success:
         skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
............

}

skbuff.h

  * Various parts of the networking layer expect at least 32 bytes of
  * headroom, you should not reduce this.
  *

* Using max(32, L1_CACHE_BYTES) makes sense (especially with RPS)

#ifndef NET_SKB_PAD
#define NET_SKB_PAD     max(32, L1_CACHE_BYTES)
#endif


--===============8743720866068770395==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMDAwMDAwIj4KICAgIDxwPjxicj4KICAgIDwv
cD4KICAgIDxicj4KICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZpeCI+T24gMDQvMjgvMjAx
NyAwOTowMyBQTSwgUmFvIFNob2FpYgogICAgICB3cm90ZTo8YnI+CiAgICA8L2Rpdj4KICAgIDxi
bG9ja3F1b3RlCiAgICAgIGNpdGU9Im1pZDo0YjAxMDI4OC1iNmJhLTkzYzItNTcyOS01NWFjOGJi
YzljOWFAb3JhY2xlLmNvbSIKICAgICAgdHlwZT0iY2l0ZSI+CiAgICAgIDxibG9ja3F1b3RlIHR5
cGU9ImNpdGUiIHN0eWxlPSJjb2xvcjogIzAwMDAwMDsiPgogICAgICAgIDxibG9ja3F1b3RlIHR5
cGU9ImNpdGUiIHN0eWxlPSJjb2xvcjogIzAwMDAwMDsiPk9uIHRoZSByeCBzaWRlLAogICAgICAg
ICAgb3ZlcndyaXRpbmcgdGhlIG5ldHdvcmsgb3IgbWFjIGhlYWRlcnMgZG9lc24ndCBzZWVtIHJp
Z2h0IC0KICAgICAgICAgIHdoYXQgaWYgdGhlIHNrYiB3YXMgY2xvbmVkIGZvciBtb25pdG9yaW5n
IHB1cnBvc2VzPyA8L2Jsb2NrcXVvdGU+CiAgICAgICAgVGhpcyBpcyBhIHZhbGlkIGNvbmNlcm4g
LS0gbGV0IG1lIHRoaW5rIGFib3V0IGl0IGEgbGl0dGxlIGJpdC4KICAgICAgICBXaGVyZSB3b3Vs
ZCB0aGUgYnVmZmVyIGJlIGNsb25lZCA/CiAgICAgICAgPGJyPgogICAgICA8L2Jsb2NrcXVvdGU+
CiAgICAgIE9oIEkganVzdCByZWFsaXplZCwgSSBzZW50IG91dCBhIHBjYXAgZmlsZSB3aGlsZSBk
b2luZyBtb3N0bHkgUngKICAgICAgdHJhZmZpYy4gSSBkaWQgbm90IHNlZSBhbnkgY29ycnVwdGlv
biBzbyBJIGFtIG5vdCBzdXJlIHRoaXMgaXMgYW4KICAgICAgaXNzdWUuIFRvIGJlIHN1cmUgSSB3
b3VsZCBoYXZlIHRvIGRpZyBpbnRvIHRoZSBjb2RlIGFzIHRvIHdoYXQKICAgICAgaGFwcGVucyB3
aGVuIHRoZSBwcm9taXNjdW91cyBtb2RlIGlzIG9uLgogICAgICA8YnI+CiAgICAgIDxicj4KICAg
ICAgUmFvLgogICAgPC9ibG9ja3F1b3RlPgogICAgPHA+VGhlIHJlYXNvbiBJIGRpZCBub3Qgc2Vl
IGFueSBjb3JydXB0aW9uIG9uIHJlY2VpdmVkIHBhY2tldHMgaXOgCiAgICAgIGJlY2F1c2Ugb24g
UnggdGhlIHNrYiBhbGxvY2F0ZWQgaGFzIGV4dHJhIGhlYWQgcm9vbS4gTkVUX0lQX0FMSUdOCiAg
ICAgIGNhbiBiZSB6ZXJvIGJ1dCBORVRfU0tCX1BBRCBpcyBub3QuIFNvIHVzaW5nIHNwYWNlIHJp
Z2h0IGJlbG93CiAgICAgIGhlYWQgaXMganVzdCBmaW5lIGJlY2F1c2UgYnkgdGhlIHRpbWUgdGhl
IHBhY2tldCByZWFjaGVzIE1QVENQIHRoZQogICAgICBzcGFjZSBpcyBub3QgYmVpbmcgdXNlZC4g
U28gaXQgdHVybnMgb3V0IHRoYXQgd2hhdCBpcyBiZWluZyBkb25lCiAgICAgIGZvciBNUFRDUCBv
biB0aGUgVHggc2lkZSBpcyBhbHJlYWR5IGhhcHBlbmluZyBvbiB0aGUgUnggc2lkZS48YnI+CiAg
ICA8L3A+CiAgICA8cD5XaGlsZSB3ZSBsb29rIGF0IG90aGVyIGJldHRlciBzb2x1dGlvbnMgSSBt
YXkgc2VuZCB0aGlzIHBhdGNoIHRvCiAgICAgIHRoZSBtcHRjcC1kZXYgbWFpbGluZyBsaXN0IHRv
IGdldCBtb3JlIGNvbW1lbnRzIGFzIEkgbWF5IGJlCiAgICAgIG92ZXJsb29raW5nIHNvbWUgb3Ro
ZXIgaXNzdWVzIGFzIHdlbGwuPGJyPgogICAgPC9wPgogICAgPHA+UmFvLjxicj4KICAgIDwvcD4K
ICAgIDxwPnN0cnVjdCBza19idWZmICpfX25hcGlfYWxsb2Nfc2tiKHN0cnVjdCBuYXBpX3N0cnVj
dCAqbmFwaSwKICAgICAgdW5zaWduZWQgaW50IGxlbiw8YnI+CiAgICAgIKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgIGdmcF90IGdmcF9tYXNrKTxicj4KICAgICAgezxicj4KICAgICAg
oKCgoKCgoCBzdHJ1Y3QgbmFwaV9hbGxvY19jYWNoZSAqbmMgPQogICAgICB0aGlzX2NwdV9wdHIo
JmFtcDtuYXBpX2FsbG9jX2NhY2hlKTs8YnI+CiAgICAgIKCgoKCgoKAgc3RydWN0IHNrX2J1ZmYg
KnNrYjs8YnI+CiAgICAgIKCgoKCgoKAgdm9pZCAqZGF0YTs8YnI+CiAgICAgIDxicj4KICAgICAg
oKCgoKCgoCBsZW4gKz0gTkVUX1NLQl9QQUQgKyBORVRfSVBfQUxJR047PGJyPgogICAgICA8YnI+
CiAgICAgICZsdDsuLi4uLi4uLi4uLi4uJmd0OzwvcD4KICAgIDxwPnNrYl9zdWNjZXNzOjxicj4K
ICAgICAgoKCgoKCgoCBza2JfcmVzZXJ2ZShza2IsIE5FVF9TS0JfUEFEICsgTkVUX0lQX0FMSUdO
KTs8YnI+CiAgICAgIC4uLi4uLi4uLi4uLjwvcD4KICAgIDxwPn08L3A+CiAgICA8cD5za2J1ZmYu
aDwvcD4KICAgIDxwPqAqIFZhcmlvdXMgcGFydHMgb2YgdGhlIG5ldHdvcmtpbmcgbGF5ZXIgZXhw
ZWN0IGF0IGxlYXN0IDMyIGJ5dGVzCiAgICAgIG9mPGJyPgogICAgICCgKiBoZWFkcm9vbSwgeW91
IHNob3VsZCBub3QgcmVkdWNlIHRoaXMuPGJyPgogICAgICCgKjxicj4KICAgICAgPGJyPgogICAg
PC9wPgogICAgPHA+KiBVc2luZyBtYXgoMzIsIEwxX0NBQ0hFX0JZVEVTKSBtYWtlcyBzZW5zZSAo
ZXNwZWNpYWxseSB3aXRoIFJQUyk8L3A+CiAgICA8cD4jaWZuZGVmIE5FVF9TS0JfUEFEPGJyPgog
ICAgICAjZGVmaW5lIE5FVF9TS0JfUEFEoKCgoCBtYXgoMzIsIEwxX0NBQ0hFX0JZVEVTKTxicj4K
ICAgICAgI2VuZGlmPGJyPgogICAgICA8YnI+CiAgICA8L3A+CiAgPC9ib2R5Pgo8L2h0bWw+Cg==

--===============8743720866068770395==--
