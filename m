Content-Type: multipart/mixed; boundary="===============0840508365921713264=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix DSS map generation on fin
 retransmission
Date: Wed, 01 Jul 2020 14:12:28 +0200
Message-ID: <c85a1cef-7f04-d43e-e1f8-1dfaa816b8cf@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2006301127330.27064@ptcotton-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4882

--===============0840508365921713264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat, Christoph

On 30/06/2020 20:28, Mat Martineau wrote:
> On Fri, 26 Jun 2020, Paolo Abeni wrote:
> =

>> The RFC 8684 mandates that no-data DATA FIN packets should carry
>> a DSS with 0 sequence number and data len equal to 1. Currently,
>> on FIN retransmission we re-use the existing mapping; if the previous
>> fin transmission was part of a partially acked data packet, we could
>> end-up writing in the egress packet a non-compliant DSS.
>>
>> The above will be detected by a "Bad mapping" warning on the receiver
>> side.
>>
>> This change addresses the issue explicitly checking for 0 len packet
>> when adding the DATA_FIN option.
>>
>> Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data =

>> packets")
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> =

> Thanks Paolo, looks good.
> =

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Thank you for the patch, the validation and the reviews!

@Christoph: it seems "Reviewed-and-tested-by" tag is not recognised by =

Patchwork so I split them :)

I added this patch at the end:

- aea4d1ebbc5f: mptcp: fix DSS map generation on fin retransmission
- d8ab2db3ac90..3813e7acdac2: result

Tests and export are in progress.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0840508365921713264==--
