Content-Type: multipart/mixed; boundary="===============3726397171811272845=="
MIME-Version: 1.0
From: Luc Van Oostenryck <luc.vanoostenryck at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 01/26] bpfilter: fix up a sparse annotation
Date: Thu, 23 Jul 2020 13:14:47 +0200
Message-ID: <20200723111447.3xj7cidlsspofsja@ltop.local>
In-Reply-To: 20200723060908.50081-2-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5240

--===============3726397171811272845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 08:08:43AM +0200, Christoph Hellwig wrote:
> The __user doesn't make sense when casting to an integer type, just
> switch to a uintptr_t cast which also removes the need for the __force.

Feel free to add my:

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck(a)gmail.com>

-- Luc
--===============3726397171811272845==--
