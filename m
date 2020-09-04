Content-Type: multipart/mixed; boundary="===============1423245008697033637=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v7 mptcp-next 0/4] add ADD_ADDR echo flag
 support
Date: Fri, 04 Sep 2020 17:48:33 +0200
Message-ID: <14503f54-b4b3-4496-0549-8958f9b77a2b@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2008311725450.53878@dgilroy-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5723

--===============1423245008697033637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 01/09/2020 02:26, Mat Martineau wrote:
> =

> On Fri, 28 Aug 2020, Geliang Tang wrote:
> =

>> v7:
>> - add accept_subflow re-check
>>
> =

> v7 looks good to add to the export branch, thank you for the changes.

Thank you for the patches and the review!

Just added in the tree just after your 3 previous patches related to =

RM_ADDR. Because of that, I had 2 simple conflicts before of the =

modifications in the MIB:

   - e864f2897303: conflict in t/mptcp-add-OoO-related-mibs

I also added Mat's Reviewed-by.

Tests + export are in progress.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1423245008697033637==--
