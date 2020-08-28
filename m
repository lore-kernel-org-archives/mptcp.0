Content-Type: multipart/mixed; boundary="===============6470428378971343751=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] Squash-to: "mptcp: cleanup
 mptcp_subflow_discard_data()"
Date: Fri, 28 Aug 2020 21:14:48 +0200
Message-ID: <175b3a22-0cd4-4d6b-1b60-5bac1c2ce44f@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2008270818090.5728@waberry-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5658

--===============6470428378971343751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 27/08/2020 17:19, Mat Martineau wrote:
> =

> On Thu, 27 Aug 2020, Paolo Abeni wrote:
> =

>> While discarding old data we also need to flush the
>> related map, if completed/exausted.
>>
>> Additionally, use a safer condition to check for to-be-eaten
>> skbs
>>
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> ---
>> v1 -> v2:
>> - fix seq check using before - Mat
>>
>> with this and pending Florian's patches, the kernel survived
>> the following loop for quite a bit.
>>
>> while true; do
>> =C2=A0=C2=A0=C2=A0=C2=A0./mptcp_connect.sh -d 10 -l 0 -r 0 -e "" -f $((1=
00 * 1024 * 1024)) =

>> -m poll
>> done
>>
>> I still see poll timeout with both ends not readable - not
>> investigated yet.
>> ---
>> net/mptcp/subflow.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
> =

> Looks good to me, thanks!
> =

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Thank you for the patch and the review!

- 5f0b72ded99d: Squash-to: "mptcp: cleanup mptcp_subflow_discard_data()"
- b7b93f993a82..e76b558ea71a: result

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6470428378971343751==--
