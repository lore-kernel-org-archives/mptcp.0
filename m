Content-Type: multipart/mixed; boundary="===============2523372167928657772=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2] Squash to "selftests: mptcp: add
 addr argument for del_addr"
Date: Sat, 13 Mar 2021 11:16:24 +0100
Message-ID: <581b80c5-be0e-a7f9-d76d-93dcbef9a99b@tessares.net>
In-Reply-To: 86ce39db-8474-4dc1-5e12-42a9a4ecc12f@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8146

--===============2523372167928657772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 12/03/2021 20:01, Mat Martineau wrote:
> On Fri, 12 Mar 2021, Matthieu Baerts wrote:
> =

>> Avoid calling pm_nl_ctl with id > 255.

(...)

> Thanks for the fix Matthieu, looks good to me.

Thank you for the review!
After some discussions with Geliang in the v1, it was decided to create =

a standalone patch instead. Please see:

https://patchwork.ozlabs.org/project/mptcp/patch/20210312151358.3426301-1-m=
atthieu.baerts(a)tessares.net/

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2523372167928657772==--
