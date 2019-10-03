Content-Type: multipart/mixed; boundary="===============9171939476443529473=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Thu, 03 Oct 2019 09:46:27 +0200
Message-ID: <20191003074627.GD13866@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1910021737190.33041@syitbare-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2007

--===============9171939476443529473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > Regenerating those and resending. Sorry!
> > =

> =

> Based on Dave's feedback, it looked like a bad idea to repost the correct=
 43
> patches today.

Yes, I agree it was good to not send it.

> Sorry again about the error on my part, we can discuss how to
> partition the patch series (and possibly squash some more patches) at the
> meeting tomorrow.

Unfortunately I won't make the meeting today.

I would suggest to make another RFC submission on Friday or Monday,
consisting only of the non-mptcp patches, i.e.:

      net: Make sock protocol value checks more specific
      sock: Make sk_protocol a 16-bit value
      tcp: Define IPPROTO_MPTCP
      tcp, ulp: Add clone operation to tcp_ulp_ops
      tcp: Prevent coalesce/collapse when skb has MPTCP extensions
      tcp: Export low-level TCP functions
      tcp: Check for filled TCP option space before SACK
      tcp: clean ext on tx recycle
      tcp: Expose tcp struct and routine for MPTCP


Wrt to =

      tcp: clean ext on tx recycle

I think this is in fact a bug fix, I think this should
call both skb_ext_reset+nf_reset_ct.

(I am not 100% sure the nf_ct pointer is always cleared already
 on skbs that we put back on per sk cache).

Same for secpath.

Cheers,
Florian
--===============9171939476443529473==--
