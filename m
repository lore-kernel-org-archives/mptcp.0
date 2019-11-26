Content-Type: multipart/mixed; boundary="===============6707046971769487984=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] mptcp: Basic single-subflow DATA_FIN
Date: Tue, 26 Nov 2019 10:07:50 +0100
Message-ID: <00b46db3-f865-c18d-2d13-13b4986a9d86@tessares.net>
In-Reply-To: 932db8d3875db21b310fb231d03596e77af21633.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2693

--===============6707046971769487984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo,

On 25/11/2019 18:00, Paolo Abeni wrote:
> On Fri, 2019-11-22 at 15:01 -0800, Mat Martineau wrote:
>> Send a DATA_FIN along with any subflow TCP FIN flag when the MPTCP
>> socket is closing or shutting down writes.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> =

> The patch LGTM, thanks!

Thank you for the new version and the review!

Where can I apply it? I would like to apply it just before the =

introduction of the kselftests but please tell me if it is better to =

squash it / apply it somewhere else.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6707046971769487984==--
