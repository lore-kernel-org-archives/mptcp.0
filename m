Content-Type: multipart/mixed; boundary="===============7506779186542666280=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: add
 rm_list in mptcp_out_options"
Date: Wed, 17 Feb 2021 20:37:20 +0100
Message-ID: <1cdc24ff-5f07-7d6f-2ab7-32774f287cb1@tessares.net>
In-Reply-To: 81d81d67-a9f5-d858-e54-7e8bc89f6542@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7831

--===============7506779186542666280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 17/02/2021 02:39, Mat Martineau wrote:
> On Tue, 16 Feb 2021, Geliang Tang wrote:
> =

>> This patch fixed the following smatch warnings:
>> net/mptcp/options.c:687 mptcp_established_options_rm_addr() error: =

>> uninitialized symbol 'align'.
>>
>> Reported-by: kernel test robot <lkp(a)intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter(a)oracle.com>
>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>> ---
>> v2:
>> - use roundup in mptcp_rm_addr_len
> =

> v2 looks good, thanks Geliang.

Thank you for the patch, the review and having reported the bug!

Now in our tree:

- 205001dc32f7: "squashed" in "mptcp: add rm_list in mptcp_out_options"
- Results: 3f93745ba205..230a407eae19

Tests + export have been queued!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7506779186542666280==--
