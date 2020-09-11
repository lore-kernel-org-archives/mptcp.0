Content-Type: multipart/mixed; boundary="===============3385970204952484885=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: call tcp_cleanup_rbuf on subflows
Date: Fri, 11 Sep 2020 12:53:57 +0200
Message-ID: <27025fbf-9e83-9637-86fb-8508b36d3f2a@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2009101630360.6323@pbudhkar-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5801

--===============3385970204952484885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 11/09/2020 01:31, Mat Martineau wrote:
> =

> On Thu, 10 Sep 2020, Paolo Abeni wrote:
> =

>> That is needed to let the subflows announce promply when new
>> space is available in the receive buffer.
>>
>> tcp_cleanup_rbuf() is currently a static function, drop the
>> scope modifier and add a declaration in the TCP header.
>>
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> -- =

>> should be inserted just before "mptcp: simult flow self-tests"
>>
>> v1 -> v2:
>> - move tcp_cleanup_rbuf() declaration inside the headers
>> ---
> =

> v2 looks good for the export branch, thanks Paolo.

Thank you for the patch and the review!

This patch has been added just before: t/mptcp-simult-flow-self-tests

- 341c313c53a5..2e7e0cdd7acd: result

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3385970204952484885==--
