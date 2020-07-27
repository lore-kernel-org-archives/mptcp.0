Content-Type: multipart/mixed; boundary="===============9009915985484865256=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 19/26] net/ipv6: switch ipv6_flowlabel_opt to
 sockptr_t
Date: Mon, 27 Jul 2020 15:00:29 +0200
Message-ID: <20200727130029.GA26393@lst.de>
In-Reply-To: 20200727121505.GA1804864@shredder
X-Status: 
X-Keywords:                  
X-UID: 5315

--===============9009915985484865256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 03:15:05PM +0300, Ido Schimmel wrote:
> I see a regression with IPv6 flowlabel that I bisected to this patch.
> When passing '-F 0' to 'ping' the flow label should be random, yet it's
> the same every time after this patch.

Can you send a reproducer?

> =

> It seems that the pointer is never advanced after the call to
> sockptr_advance() because it is passed by value and not by reference.
> Even if you were to pass it by reference I think you would later need to
> call sockptr_decrease() or something similar. Otherwise it is very
> error-prone.
> =

> Maybe adding an offset to copy_to_sockptr() and copy_from_sockptr() is
> better?

We could do that, although I wouldn't add it to the existing functions
to avoid the churns and instead add copy_to_sockptr_offset or something
like that.
--===============9009915985484865256==--
