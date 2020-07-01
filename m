Content-Type: multipart/mixed; boundary="===============1528933848215505904=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: init autotune state also in
 simultaneous connect case.
Date: Wed, 01 Jul 2020 13:42:47 +0200
Message-ID: <24ae05b6-b4ea-39ec-25f3-73aadb1f94bc@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2006301144100.27064@ptcotton-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4881

--===============1528933848215505904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat, Paolo,

On 30/06/2020 20:44, Mat Martineau wrote:
> On Tue, 30 Jun 2020, Paolo Abeni wrote:
> =

>> On Mon, 2020-06-22 at 15:57 +0200, Florian Westphal wrote:
>>> This is what Christoph suggested needs to be added to avoid
>>> div0 in case of simultaneous connect.
>>>
>>> Squashto: mptcp: add receive buffer auto-tuning
>>
>> LGTM, and I think Christoph already acked it.
> =

> Yes, definitely good to squash this.

Thank you for the patch and the review! Just applied:

- e6df694a4180: "squashed" in "mptcp: add receive buffer auto-tuning"
- 8de6e2516b12..d8ab2db3ac90: result

Tests and export will be started soon.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1528933848215505904==--
